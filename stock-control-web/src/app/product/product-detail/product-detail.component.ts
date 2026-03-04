import { Component, OnInit, inject, ChangeDetectorRef } from '@angular/core'; // 1. Import ChangeDetectorRef
import { CommonModule } from '@angular/common';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatTooltipModule } from '@angular/material/tooltip';
import { ProductService } from '../product.service';
import { Product } from '../product.model';

@Component({
  selector: 'app-product-detail',
  standalone: true,
  imports: [CommonModule, RouterModule, MatButtonModule, MatIconModule, MatTooltipModule],
  templateUrl: './product-detail.component.html'
})
export class ProductDetailComponent implements OnInit {
  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private productService = inject(ProductService);
  private cdr = inject(ChangeDetectorRef);

  product?: Product;
  loading = true;
  errorMessage = '';

  ngOnInit(): void {
    const idParam = this.route.snapshot.paramMap.get('id');
    const id = Number(idParam);

    if (id) {
      this.productService.findById(id).subscribe({
        next: (data) => {
          this.product = data;
          this.loading = false;

          this.cdr.detectChanges();
        },
        error: (err) => {
          console.error(err);
          this.errorMessage = 'Error fetching the product from the server.';
          this.loading = false;
          this.cdr.detectChanges();
        }
      });
    } else {
      this.errorMessage = 'Invalid product ID in the URL.';
      this.loading = false;
      this.cdr.detectChanges();
    }
  }

  onDelete(): void {
    if (this.product?.id && confirm('Are you sure you want to delete this product?')) {
      this.productService.remove(this.product.id).subscribe(() => {
        this.router.navigate(['/products']);
      });
    }
  }
}
