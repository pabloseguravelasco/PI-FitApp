import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { DietResponse } from '../models/interfaces/diet.interface';

const dietUrl = `${environment.apiBaseUrl}/diet`;


@Injectable({
  providedIn: 'root'
})
export class DietService {

  constructor(private http: HttpClient) { }

  getDiets(): Observable<DietResponse> {
    return this.http.get<DietResponse>(`${dietUrl}`);
  }
}
