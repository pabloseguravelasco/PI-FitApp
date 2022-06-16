import { Component, Input, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { Exercise } from 'src/app/models/interfaces/exercise.interface';
import { AuthService } from 'src/app/services/auth.service';
import { ExerciseService } from 'src/app/services/exercise.service';
import { environment } from 'src/environments/environment';
import { DialogExerciseDetailComponent } from '../dialogs/dialog-exercise-detail/dialog-exercise-detail.component';

@Component({
  selector: 'app-exercise-item',
  templateUrl: './exercise-item.component.html',
  styleUrls: ['./exercise-item.component.css']
})
export class ExerciseItemComponent implements OnInit {
  @Input() exerciseInput!: Exercise;

  constructor(private matDialog : MatDialog, private exerciseService: ExerciseService
    ) { }

  ngOnInit(): void {
  }

  getExerciseImageUrl(exercise: Exercise) {
    return `${exercise.imagen}`;
  }
  
  openDialogDetail(){
    this.matDialog.open(DialogExerciseDetailComponent,{
      width: "350px",
      height: "350px",
      data:{
        exercise: this.exerciseInput
      }
    })
  }

  doDelete(id: number){

    this.exerciseService.deleteExercise(id).subscribe(results => {
      console.log('Ejercicio Eliminado')
      window.location.reload();
  })
}}






