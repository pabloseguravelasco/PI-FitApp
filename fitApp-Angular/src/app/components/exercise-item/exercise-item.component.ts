import { Component, Input, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { Exercise } from 'src/app/models/interfaces/exercise.interface';
import { AuthService } from 'src/app/services/auth.service';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-exercise-item',
  templateUrl: './exercise-item.component.html',
  styleUrls: ['./exercise-item.component.css']
})
export class ExerciseItemComponent implements OnInit {
  @Input() exerciseInput!: Exercise;

  constructor(
    private authService: AuthService,
    private dialog: MatDialog
    ) { }

  ngOnInit(): void {
  }

  getExerciseImageUrl(exercise: Exercise) {
    return exercise.imagen;
  }



}
