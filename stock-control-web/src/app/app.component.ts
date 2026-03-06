import { Component, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterOutlet, RouterLink, RouterLinkActive } from '@angular/router';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';

import Keycloak from 'keycloak-js';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [
    CommonModule,
    RouterOutlet,
    RouterLink,
    RouterLinkActive,
    MatIconModule,
    MatButtonModule,
  ],
  templateUrl: './app.component.html',
})
export class AppComponent {
  private readonly keycloak = inject(Keycloak);

  readonly navItems = [
    { path: '/dashboard', label: 'Dashboard', icon: 'grid_view' },
    { path: '/products', label: 'Products', icon: 'inventory_2' },
    { path: '/raw-materials', label: 'Raw Materials', icon: 'layers' },
    { path: '/products/suggestions', label: 'Suggestions', icon: 'analytics' },
  ] as const;

  get username(): string {
    const token = this.keycloak.tokenParsed as any;
    return token?.name || token?.preferred_username || '';
  }

  logout(): void {
    this.keycloak.logout({ redirectUri: window.location.origin });
  }
}
