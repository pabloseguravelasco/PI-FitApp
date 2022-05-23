import { Injectable } from "@angular/core";
import { HttpClient } from "@angular/common/http";
import { Observable } from "rxjs";


@Injectable({
  providedIn: "root"
})
export class UsersService {
  constructor(private http: HttpClient, ) {}


  login(user: any): Observable<any> {
    return this.http.post("", user);
  }

  setToken(token: string) {
    localStorage.setItem("token", token);
  }
  getToken() {
    return localStorage.getItem("token");
  }

  getUser() {
    return this.http.get("");
  }
  getUserLogged() {
    const token = this.getToken();
    // endpoint
  }
}