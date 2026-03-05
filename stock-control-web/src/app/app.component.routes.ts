import { Routes } from '@angular/router';
import { authGuard } from './auth.guard';

export const routes: Routes = [
  {
    path: 'products',
    canActivate: [authGuard],
    loadChildren: () => import('./product/product.routes').then((m) => m.PRODUCT_ROUTES),
  },
  {
    path: 'raw-materials',
    canActivate: [authGuard],
    loadChildren: () =>
      import('./raw-material/raw-material.routes').then((m) => m.RAW_MATERIAL_ROUTES),
  },
  { path: '', redirectTo: 'products', pathMatch: 'full' },
];
