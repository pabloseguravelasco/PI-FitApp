import { Component, Inject, OnInit } from '@angular/core';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Diet } from 'src/app/models/interfaces/diet.interface';
import { DietService } from 'src/app/services/diet.service';


@Component({
  selector: 'app-dialog-diet-detail',
  templateUrl: './dialog-diet-detail.component.html',
  styleUrls: ['./dialog-diet-detail.component.css']
})
export class DialogDietDetailComponent implements OnInit {

  constructor(@Inject(MAT_DIALOG_DATA) private data: DialogDietDetailComponent, private dietService: DietService) { }

  diet!: Diet;
  
  ngOnInit(): void {
    this.diet = this.data.diet
  }

}
