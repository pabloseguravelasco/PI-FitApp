import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { ExerciseResponse } from '../models/interfaces/exercise.interface';

const exerciseUrl = `${environment.apiBaseUrl}/exercise/list`;
const DEFAULT_HEADERS = {
  headers: new HttpHeaders({
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${localStorage.getItem('token')}` 
  })
};

@Injectable({
  providedIn: 'root'
})
export class ExerciseService {

  constructor(private http: HttpClient) { }

  getExercises(): Observable<ExerciseResponse> {
    return this.http.get<ExerciseResponse>(`${exerciseUrl}`,DEFAULT_HEADERS);
  }

  deleteExercise(id:Number) {
    return this.http.delete(`${environment.apiBaseUrl}/exercise/${id}`,DEFAULT_HEADERS);
  }
}
