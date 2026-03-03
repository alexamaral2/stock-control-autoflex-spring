import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../environments/environment';
import { Product } from './product.model';
import { ProductionSuggestionResponse } from './production-suggestions/production-suggestion.model';

@Injectable({ providedIn: 'root' })
export class ProductService {
  private http = inject(HttpClient);
  private readonly API = `${environment.apiURL}/products`;

  listAll() {
    return this.http.get<Product[]>(this.API);
  }

  save(product: Product) {
    return this.http.post<Product>(this.API, product);
  }

  remove(id: number) {
    return this.http.delete<void>(`${this.API}/${id}`);
  }
  findById(id: number) {
    return this.http.get<Product>(`${this.API}/${id}`);
  }

  update(id: number, product: Product) {
    return this.http.put<Product>(`${this.API}/${id}`, product);
  }

  getProductionSuggestions() {
    return this.http.get<ProductionSuggestionResponse>(`${this.API}/production-suggestions`);
  }
}
