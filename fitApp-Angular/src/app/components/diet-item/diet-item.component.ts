import { Component, Input, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { Diet } from 'src/app/models/interfaces/diet.interface';
import { AuthService } from 'src/app/services/auth.service';
import { DietService } from 'src/app/services/diet.service';
import { environment } from 'src/environments/environment';
import { DialogDietDetailComponent } from '../dialogs/dialog-diet-detail/dialog-diet-detail.component';

@Component({
  selector: 'app-diet-item',
  templateUrl: './diet-item.component.html',
  styleUrls: ['./diet-item.component.css']
})
export class DietItemComponent implements OnInit {
  @Input() dietInput!: Diet;

  constructor(private matDialog : MatDialog,private dietService: DietService
   
    ) { }

  ngOnInit(): void {
  }

  getDietImageUrl(diet: Diet) {
    return `${diet.imagen}`;
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

  doDelete(id: number){

    this.dietService.deleteDiet(id).subscribe(results => {
      console.log('Ejercicio Eliminado')
      window.location.reload();
  })
}



}
