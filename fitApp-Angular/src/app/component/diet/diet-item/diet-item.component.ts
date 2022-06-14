import { Component, Input, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { DialogDietDetailComponent } from 'src/app/dialogs/dialog-diet-detail/dialog-diet-detail.component';
import { Diet } from 'src/app/models/interfaces/diet';

@Component({
  selector: 'app-diet-item',
  templateUrl: './diet-item.component.html',
  styleUrls: ['./diet-item.component.css']
})
export class DietItemComponent implements OnInit {

  @Input() dietInput!: Diet;
 
  constructor(private matDialog : MatDialog) { }

  ngOnInit(): void {
  }

  openDialogDetail(){
    this.matDialog.open(DialogDietDetailComponent,{
      width: "350px",
      height: "350px",
      data:{
        diet: this.dietInput
      }
    })
  }


}
