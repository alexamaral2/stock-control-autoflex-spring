import { Component, OnInit, inject, signal, ViewChild, effect } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatTableModule, MatTableDataSource } from '@angular/material/table';
import { MatPaginator, MatPaginatorModule } from '@angular/material/paginator';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { ProductService } from '../product.service';
import { ProductSuggestion } from './production-suggestion.model';

@Component({
  selector: 'app-production-suggestions',
  standalone: true,
  imports: [CommonModule, MatTableModule, MatPaginatorModule, MatIconModule, MatButtonModule],
  templateUrl: './production-suggestions.component.html',
})
export class ProductionSuggestionsComponent implements OnInit {
  private service = inject(ProductService);

  suggestions = signal<ProductSuggestion[]>([]);
  totalValue = signal<number>(0);

  displayedColumns: string[] = [
    'productCode',
    'productName',
    'quantityToProduce',
    'unitPrice',
    'subtotal',
  ];
  dataSource = new MatTableDataSource<ProductSuggestion>([]);

  @ViewChild(MatPaginator) paginator!: MatPaginator;

  constructor() {
    effect(() => {
      this.dataSource.data = this.suggestions();
      this.dataSource.paginator = this.paginator;
    });
  }

  ngOnInit(): void {
    this.service.getProductionSuggestions().subscribe((res) => {
      this.suggestions.set(res.suggestions);
      this.totalValue.set(res.totalEstimatedValue);
    });
  }

  applyFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.dataSource.filter = filterValue.trim().toLowerCase();
  }
}
