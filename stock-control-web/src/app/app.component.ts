import { Component } from '@angular/core';
import { RouterOutlet, RouterLink, RouterLinkActive } from '@angular/router';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatTooltipModule } from '@angular/material/tooltip';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [
    CommonModule,
    RouterOutlet,
    RouterLink,
    RouterLinkActive,
    MatButtonModule,
    MatIconModule,
    MatTooltipModule,
  ],
  templateUrl: './app.component.html',
})
export class AppComponent {
  navItems = [
    { path: '/products', label: 'Products', icon: 'inventory_2' },
    { path: '/raw-materials', label: 'Raw Materials', icon: 'layers' },
    { path: '/products/suggestions', label: 'Suggestions', icon: 'analytics' },
  ];
}
