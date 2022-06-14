import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { ExerciseResponse } from '../models/interfaces/exercise.interface';

const exerciseUrl = `${environment.apiBaseUrl}/exercise`;


@Injectable({
  providedIn: 'root'
})
export class ExerciseService {

  constructor(private http: HttpClient) { }

  getExercises(): Observable<ExerciseResponse> {
    return this.http.get<ExerciseResponse>(`${exerciseUrl}`);
  }
}
