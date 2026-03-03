import { inject, Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { RawMaterial } from './raw-material.model';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root',
})
export class RawMaterialService {
  private http = inject(HttpClient);
  private readonly API = `${environment.apiURL}/raw-materials`;

  findAll(): Observable<RawMaterial[]> {
    return this.http.get<RawMaterial[]>(this.API);
  }

  findById(id: number): Observable<RawMaterial> {
    return this.http.get<RawMaterial>(`${this.API}/${id}`);
  }

  save(record: Partial<RawMaterial>): Observable<RawMaterial> {
    return this.http.post<RawMaterial>(this.API, record);
  }

  update(id: number, record: Partial<RawMaterial>): Observable<RawMaterial> {
    return this.http.put<RawMaterial>(`${this.API}/${id}`, record);
  }

  delete(id: number): Observable<void> {
    return this.http.delete<void>(`${this.API}/${id}`);
  }
}
