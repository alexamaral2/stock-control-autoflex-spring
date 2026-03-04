import { Routes } from '@angular/router';
import { RawMaterialComponent } from './raw-material.component';
import { RawMaterialListComponent } from './raw-material-list/raw-material-list.component';
import { RawMaterialFormComponent } from './raw-material-form/raw-material-form.component';
import {RawMaterialDetailComponent} from './raw-material-detail/raw-material-detail.component';

export const RAW_MATERIAL_ROUTES: Routes = [
  {
    path: '',
    component: RawMaterialComponent,
    children: [
      {
        path: '',
        component: RawMaterialListComponent,
        title: 'Raw Materials',
      },
      {
        path: 'new',
        component: RawMaterialFormComponent,
        title: 'New Raw Material',
      },
      {
        path: 'edit/:id',
        component: RawMaterialFormComponent,
        title: 'Edit Raw Material',
      },
      {
        path: ':id',
        component: RawMaterialDetailComponent,
        title: 'Raw Material Details',
      },
    ],
  },
];
