import { Component, Input, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { Diet } from 'src/app/models/interfaces/diet.interface';
import { AuthService } from 'src/app/services/auth.service';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-diet-item',
  templateUrl: './diet-item.component.html',
  styleUrls: ['./diet-item.component.css']
})
export class DietItemComponent implements OnInit {
  @Input() dietInput!: Diet;

  constructor(
    private authService: AuthService,
    private dialog: MatDialog
    ) { }

  ngOnInit(): void {
  }

  getDietImageUrl(diet: Diet) {
    return diet.imagen;
  }



}
