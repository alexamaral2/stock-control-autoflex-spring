import { Component, OnInit, inject, signal, computed } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatTooltipModule } from '@angular/material/tooltip';
import { RouterLink } from '@angular/router';
import { forkJoin, of } from 'rxjs';
import { catchError, finalize } from 'rxjs/operators';

import { ProductService } from '../product/product.service';
import { RawMaterialService } from '../raw-material/raw-material.service';
import { ProductSuggestion } from '../product/production-suggestions/production-suggestion.model';
import { Product } from '../product/product.model';
import { RawMaterial } from '../raw-material/raw-material.model';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [CommonModule, MatIconModule, MatButtonModule, MatTooltipModule, RouterLink],
  templateUrl: './dashboard.component.html'
})
export class DashboardComponent implements OnInit {
  private productService = inject(ProductService);
  private materialService = inject(RawMaterialService);

  loading = signal(true);

  private products = signal<Product[]>([]);
  private materials = signal<RawMaterial[]>([]);
  suggestions = signal<ProductSuggestion[]>([]);

  stats = computed(() => ({
    totalProducts: this.products().length,
    totalMaterials: this.materials().length,
    lowStockMaterials: this.materials().filter(m => m.quantity < 10).length,
    catalogValue: this.products().reduce((acc, p) => acc + (p.price || 0), 0)
  }));

  ngOnInit(): void {
    this.loadDashboardData();
  }

  loadDashboardData(): void {
    forkJoin({
      products: this.productService.listAll().pipe(catchError(() => of<Product[]>([]))),

      materials: this.materialService.findAll().pipe(catchError(() => of<RawMaterial[]>([]))),

      res: this.productService.getProductionSuggestions().pipe(catchError(() => of({ suggestions: [] })))
    })
      .pipe(finalize(() => this.loading.set(false)))
      .subscribe(({ products, materials, res }) => {
        this.products.set(products);
        this.materials.set(materials);
        this.suggestions.set(res.suggestions.slice(0, 3));
      });
  }
}
