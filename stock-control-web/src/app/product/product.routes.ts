import { Routes } from '@angular/router';
import { ProductComponent } from './product.component';
import { ProductListComponent } from './product-list/product-list.component';
import { ProductFormComponent } from './product-form/product-form.component';
import { ProductionSuggestionsComponent } from './production-suggestions/production-suggestions.component';
import {ProductDetailComponent} from './product-detail/product-detail.component';

export const PRODUCT_ROUTES: Routes = [
  {
    path: '',
    component: ProductComponent,
    children: [
      {
        path: '',
        component: ProductListComponent,
        title: 'Product List',
      },
      {
        path: 'new',
        component: ProductFormComponent,
        title: 'New Product',
      },
      {
        path: 'edit/:id',
        component: ProductFormComponent,
        title: 'Edit Product',
      },
      {
        path: 'suggestions',
        component: ProductionSuggestionsComponent,
        title: 'Production Suggestions',
      },
      {
        path: ':id',
        component: ProductDetailComponent,
        title: 'Product Details',
      },
    ],
  },
];
