import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { RawMaterialService } from '../raw-material.service';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';

@Component({
  selector: 'app-raw-material-form',
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
  ],
  templateUrl: './raw-material-form.component.html',
})
export class RawMaterialFormComponent implements OnInit {
  private fb = inject(FormBuilder);
  private service = inject(RawMaterialService);
  private router = inject(Router);
  private route = inject(ActivatedRoute);
  private snackBar = inject(MatSnackBar);

  materialForm: FormGroup;
  materialId: number | null = null;

  constructor() {
    this.materialForm = this.fb.group({
      code: ['', [Validators.required]],
      name: ['', [Validators.required]],
      quantity: [0, [Validators.required, Validators.min(0)]],
    });
  }

  ngOnInit(): void {
    const id = this.route.snapshot.params['id'];
    if (id) {
      this.materialId = +id;
      this.service
        .findById(this.materialId)
        .subscribe((data) => this.materialForm.patchValue(data));
    }
  }

  onSubmit(): void {
    if (this.materialForm.valid) {
      const data = this.materialForm.value;
      const request = this.materialId
        ? this.service.update(this.materialId, data)
        : this.service.save(data);

      request.subscribe({
        next: () => {
          this.snackBar.open('Material saved!', 'Close', { duration: 3000 });
          this.router.navigate(['/raw-materials']);
        },
        error: () => this.snackBar.open('Error saving material. Code might be duplicate.', 'OK'),
      });
    }
  }
}
