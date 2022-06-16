import { Component, OnInit } from '@angular/core';
import { Exercise } from 'src/app/models/interfaces/exercise.interface';

import { AuthService } from 'src/app/services/auth.service';
import { ExerciseService } from 'src/app/services/exercise.service';


@Component({
  selector: 'app-exercise-list',
  templateUrl: './exercise-list.component.html',
  styleUrls: ['./exercise-list.component.css']
})
export class ExerciseListComponent implements OnInit {
  exercises: Exercise[] = [];

  constructor(private exerciseService: ExerciseService
  ) { }

  ngOnInit(): void {

    this.exerciseService.getExercises().subscribe(exerciseResponse => {
      this.exercises = exerciseResponse.content;

      console.log(this.exercises);
    });
  }

}
