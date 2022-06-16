import { Component, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { ActivatedRoute, Router } from '@angular/router';
import { Observable } from 'rxjs';
import { AuthService } from 'src/app/services/auth.service';


@Component({
  selector: 'app-side-menu',
  templateUrl: './side-menu.component.html',
  styleUrls: ['./side-menu.component.css']
})
export class SideMenuComponent implements OnInit {
  currentPage = 'Exercises';
  isLoggedIn$: Observable<boolean> | undefined;

  constructor(private router: Router, private dialog: MatDialog,private authService:AuthService) { }

  ngOnInit(): void {
    
      this.isLoggedIn$ = this.authService.isLoggedIn;
    }
  }


