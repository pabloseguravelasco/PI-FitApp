import { Component, Inject, OnInit } from '@angular/core';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Exercise } from 'src/app/models/interfaces/exercise.interface';
import { ExerciseService } from 'src/app/services/exercise.service';


@Component({
  selector: 'app-dialog-exercise-detail',
  templateUrl: './dialog-exercise-detail.component.html',
  styleUrls: ['./dialog-exercise-detail.component.css']
})
export class DialogExerciseDetailComponent implements OnInit {

  constructor(@Inject(MAT_DIALOG_DATA) private data: DialogExerciseDetailComponent, private exerciseService: ExerciseService) { }

  exercise!: Exercise;
  
  ngOnInit(): void {
    this.exercise = this.data.exercise
  }

}
