import { inject } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivateFn, RouterStateSnapshot } from '@angular/router';
import Keycloak from 'keycloak-js';

export const authGuard: CanActivateFn = async (route: ActivatedRouteSnapshot, state: RouterStateSnapshot) => {
  const keycloak = inject(Keycloak);

  if (!keycloak.authenticated) {
    await keycloak.login({
      redirectUri: window.location.origin + state.url
    });
    return false;
  }

  return true;
};
