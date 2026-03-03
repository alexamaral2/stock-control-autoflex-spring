import { Component, OnInit, ViewChild, inject, signal, effect } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';

import { MatTableModule, MatTableDataSource } from '@angular/material/table';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatPaginator, MatPaginatorModule } from '@angular/material/paginator';
import { MatInputModule } from '@angular/material/input';
import { MatTooltipModule } from '@angular/material/tooltip';

import { ProductService } from '../product.service';
import { Product } from '../product.model';

@Component({
  selector: 'app-product-list',
  standalone: true,
  imports: [
    CommonModule,
    RouterLink,
    MatTableModule,
    MatButtonModule,
    MatIconModule,
    MatPaginatorModule,
    MatInputModule,
    MatTooltipModule,
  ],
  templateUrl: './product-list.component.html',
})
export class ProductListComponent implements OnInit {
  private service = inject(ProductService);

  products = signal<Product[]>([]);
  displayedColumns = ['code', 'name', 'price', 'actions'];

  dataSource = new MatTableDataSource<Product>([]);

  @ViewChild(MatPaginator) paginator!: MatPaginator;

  constructor() {
    effect(() => {
      this.dataSource.data = this.products();
      this.dataSource.paginator = this.paginator;
    });
  }

  ngOnInit() {
    this.refresh();
  }

  refresh() {
    this.service.listAll().subscribe((res) => {
      this.products.set(res);
    });
  }

  applyFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.dataSource.filter = filterValue.trim().toLowerCase();

    if (this.dataSource.paginator) {
      this.dataSource.paginator.firstPage();
    }
  }

  onDelete(id: number) {
    if (confirm('Are you sure you want to delete this product?')) {
      this.service.remove(id).subscribe(() => this.refresh());
    }
  }
}
