import { Component, OnInit } from '@angular/core';
import { Diet } from 'src/app/models/interfaces/diet.interface';

import { AuthService } from 'src/app/services/auth.service';
import { DietService } from 'src/app/services/diet.service';


@Component({
  selector: 'app-diet-list',
  templateUrl: './diet-list.component.html',
  styleUrls: ['./diet-list.component.css']
})
export class DietListComponent implements OnInit {
  diets: Diet[] = [];

  constructor(private dietService: DietService,
    private authService: AuthService
    ) { }

  ngOnInit(): void {
    
    this.dietService.getDiets().subscribe(dietResponse => {
      this.diets = dietResponse.content;
    });
  }

  

}
