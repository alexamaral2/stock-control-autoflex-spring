import { Routes } from '@angular/router';

export const routes: Routes = [
  {
    path: 'products',
    loadChildren: () => import('./product/product.routes').then((m) => m.PRODUCT_ROUTES),
  },
  {
    path: 'raw-materials',
    loadChildren: () =>
      import('./raw-material/raw-material.routes').then((m) => m.RAW_MATERIAL_ROUTES),
  },
  { path: '', redirectTo: 'products', pathMatch: 'full' },
];
