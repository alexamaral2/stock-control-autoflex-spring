import { Component, OnInit, inject, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, FormArray, ReactiveFormsModule, Validators } from '@angular/forms';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';

import { ProductService } from '../product.service';
import { RawMaterialService } from '../../raw-material/raw-material.service';
import { Product } from '../product.model';

import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { MatDividerModule } from '@angular/material/divider';
import { MatSelectModule } from '@angular/material/select';
import { MatTooltipModule } from '@angular/material/tooltip';

@Component({
  selector: 'app-product-form',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    RouterModule,
    MatFormFieldModule,
    MatInputModule,
    MatButtonModule,
    MatCardModule,
    MatIconModule,
    MatSnackBarModule,
    MatDividerModule,
    MatSelectModule,
    MatTooltipModule,
  ],
  templateUrl: './product-form.component.html',
})
export class ProductFormComponent implements OnInit {
  private fb = inject(FormBuilder);
  private service = inject(ProductService);
  private rawMaterialService = inject(RawMaterialService);
  private router = inject(Router);
  private route = inject(ActivatedRoute);
  private snackBar = inject(MatSnackBar);

  productForm: FormGroup;
  productId: number | null = null;
  availableMaterials = signal<any[]>([]);

  constructor() {
    this.productForm = this.fb.group({
      code: ['', [Validators.required]],
      name: ['', [Validators.required, Validators.minLength(3)]],
      price: [null, [Validators.required, Validators.min(0.01)]],
      materials: this.fb.array([], [Validators.required]),
    });
  }

  ngOnInit(): void {
    const id = this.route.snapshot.params['id'];

    this.rawMaterialService.findAll().subscribe({
      next: (materials) => {
        this.availableMaterials.set(materials || []);
      },
      error: (err) => {
        console.error('Error fetching materials:', err);
        this.availableMaterials.set([]);
      },
    });

    if (id) {
      this.productId = +id;
      this.loadProductData(this.productId);
    } else {
      this.materials.clear();
      this.addMaterial();
    }
  }

  compareFn(o1: any, o2: any): boolean {
    return o1 && o2 ? o1.toString() === o2.toString() : o1 === o2;
  }

  get materials(): FormArray {
    return this.productForm.get('materials') as FormArray;
  }

  private loadProductData(id: number): void {
    this.service.findById(id).subscribe({
      next: (product: Product) => {
        this.materials.clear();

        if (product.materials && product.materials.length > 0) {
          product.materials.forEach((m: any) => {
            const idForForm = m.rawMaterialId || m.materialId;

            this.materials.push(
              this.fb.group({
                materialId: [idForForm, [Validators.required]],
                quantity: [m.quantity, [Validators.required, Validators.min(1)]],
              }),
            );
          });
        }

        this.productForm.patchValue({
          code: product.code,
          name: product.name,
          price: product.price,
        });
      },
    });
  }

  addMaterial(): void {
    const materialGroup = this.fb.group({
      materialId: [null, [Validators.required]],
      quantity: [1, [Validators.required, Validators.min(1)]],
    });
    this.materials.push(materialGroup);
  }

  removeMaterial(index: number): void {
    if (this.materials.length > 1) {
      this.materials.removeAt(index);
    }
  }

  onSubmit(): void {
    if (this.productForm.valid) {
      const formValue = this.productForm.value;
      const payload = {
        ...formValue,
        materials: formValue.materials.map((m: any) => ({
          rawMaterialId: m.materialId,
          quantity: m.quantity,
        })),
      };

      const request = this.productId
        ? this.service.update(this.productId, payload)
        : this.service.save(payload);

      request.subscribe({
        next: () => {
          this.snackBar.open('Saved successfully!', 'Close', { duration: 3000 });
          this.router.navigate(['/products']);
        },
      });
    }
  }
}
