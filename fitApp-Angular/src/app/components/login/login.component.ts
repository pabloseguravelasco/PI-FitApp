import { Component, OnInit } from "@angular/core";
import { FormBuilder, FormGroup, Validators } from "@angular/forms";
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
  form: FormGroup | undefined;
 
  constructor(private authService: AuthService, private route:Router,private fb: FormBuilder) { }

  ngOnInit(): void {
    this.form = this.fb.group({
      email: ['', Validators.required],
      password: ['', Validators.required]
    });
  }

  doLogin() {
    this.authService.login(this.loginDto).subscribe(loginResult => {
      localStorage.setItem('token',loginResult.token);
      this.route.navigate(['/exercise/list']);
    })
  }

  

}
