import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { DietResponse } from '../models/interfaces/diet.interface';

const dietUrl = `${environment.apiBaseUrl}/diet/list`;
const DEFAULT_HEADERS = {
  headers: new HttpHeaders({
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${localStorage.getItem('token')}` 
  })}

@Injectable({
  providedIn: 'root'
})
export class DietService {

  constructor(private http: HttpClient) { }

  getDiets(): Observable<DietResponse> {
    return this.http.get<DietResponse>(`${dietUrl}`,DEFAULT_HEADERS);
  }

  deleteDiet(id:Number) {
    return this.http.delete(`${environment.apiBaseUrl}/diet/${id}`,DEFAULT_HEADERS);
  }
}
