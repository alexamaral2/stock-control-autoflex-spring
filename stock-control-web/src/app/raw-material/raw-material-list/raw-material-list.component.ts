import { Component, OnInit, inject, signal, ViewChild, effect } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Router } from '@angular/router'; // Importado o Router
import { MatTableModule, MatTableDataSource } from '@angular/material/table';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatCardModule } from '@angular/material/card';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { MatPaginator, MatPaginatorModule } from '@angular/material/paginator';

import { RawMaterialService } from '../raw-material.service';
import { RawMaterial } from '../raw-material.model';

@Component({
  selector: 'app-raw-material-list',
  standalone: true,
  imports: [
    CommonModule,
    RouterModule,
    MatTableModule,
    MatButtonModule,
    MatIconModule,
    MatCardModule,
    MatTooltipModule,
    MatSnackBarModule,
    MatPaginatorModule,
  ],
  templateUrl: './raw-material-list.component.html',
})
export class RawMaterialListComponent implements OnInit {
  private service = inject(RawMaterialService);
  private snackBar = inject(MatSnackBar);
  private router = inject(Router); // Router injetado

  materials = signal<RawMaterial[]>([]);
  displayedColumns: string[] = ['code', 'name', 'quantity', 'actions'];

  dataSource = new MatTableDataSource<RawMaterial>([]);

  @ViewChild(MatPaginator) paginator!: MatPaginator;

  constructor() {
    effect(() => {
      this.dataSource.data = this.materials();
      if (this.paginator) {
        this.dataSource.paginator = this.paginator;
      }
    });
  }

  ngOnInit(): void {
    this.loadMaterials();
  }

  loadMaterials(): void {
    this.service.findAll().subscribe((data) => this.materials.set(data));
  }

  onRowClick(material: RawMaterial): void {
    this.router.navigate(['/raw-materials', material.id]);
  }

  applyFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.dataSource.filter = filterValue.trim().toLowerCase();

    if (this.dataSource.paginator) {
      this.dataSource.paginator.firstPage();
    }
  }

  onDelete(event: Event, id: number): void {
    event.stopPropagation();
    if (confirm('Are you sure you want to delete this raw material?')) {
      this.service.delete(id).subscribe(() => {
        this.snackBar.open('Material deleted successfully', 'OK', { duration: 3000 });
        this.loadMaterials();
      });
    }
  }
}
