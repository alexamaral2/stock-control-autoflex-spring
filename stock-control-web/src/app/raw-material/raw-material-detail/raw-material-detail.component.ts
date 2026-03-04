import { Component, OnInit, inject, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { RawMaterialService } from '../raw-material.service';
import { RawMaterial } from '../raw-material.model';

@Component({
  selector: 'app-raw-material-detail',
  standalone: true,
  imports: [CommonModule, RouterModule, MatButtonModule, MatIconModule, MatTooltipModule, MatSnackBarModule],
  templateUrl: './raw-material-detail.component.html'
})
export class RawMaterialDetailComponent implements OnInit {
  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private service = inject(RawMaterialService);
  private cdr = inject(ChangeDetectorRef);
  private snackBar = inject(MatSnackBar);

  material?: RawMaterial;
  loading = true;
  errorMessage = '';

  ngOnInit(): void {
    const idParam = this.route.snapshot.paramMap.get('id');
    const id = Number(idParam);

    if (id) {
      this.service.findById(id).subscribe({
        next: (data) => {
          this.material = data;
          this.loading = false;
          this.cdr.detectChanges();
        },
        error: (err) => {
          console.error(err);
          this.errorMessage = 'Error fetching the raw material from the server.';
          this.loading = false;
          this.cdr.detectChanges();
        }
      });
    } else {
      this.errorMessage = 'Invalid material ID in the URL.';
      this.loading = false;
      this.cdr.detectChanges();
    }
  }

  onDelete(): void {
    if (this.material?.id && confirm('Are you sure you want to delete this raw material?')) {
      this.service.delete(this.material.id).subscribe(() => {
        this.snackBar.open('Material deleted successfully', 'OK', { duration: 3000 });
        this.router.navigate(['/raw-materials']);
      });
    }
  }
}
