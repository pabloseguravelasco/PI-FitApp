import { Component, OnInit } from "@angular/core";
import { Router } from "@angular/router";
import { LoginDto } from "src/app/models/interfaces/auth.interface";
import { AuthService } from "src/app/services/auth.service";

;


@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  loginDto = new LoginDto();

  constructor(private authService: AuthService, private route:Router) { }

  ngOnInit(): void {
  }

  doLogin() {
    this.authService.login(this.loginDto).subscribe(loginResult => {
      localStorage.setItem('token',loginResult.token);
      this.route.navigate(['/exercise/list']);
    })
  }

}
