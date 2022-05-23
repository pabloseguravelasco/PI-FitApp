

import { routing } from "./app-routing.module";
import { BrowserModule } from "@angular/platform-browser";
import { NgModule } from "@angular/core";
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

import { AppComponent } from "./app.component";
import { LoginComponent } from "./login/login.component";
import { HttpClientModule } from '@angular/common/http';

import { MaterialImportsModule } from './modules/material-imports.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import {MatSliderModule} from '@angular/material/slider';
import {MatToolbarModule} from '@angular/material/toolbar';





@NgModule({
  declarations: [
    AppComponent, 
    LoginComponent,
  ],



  imports: [  BrowserModule,
    BrowserAnimationsModule,
    MaterialImportsModule,
    HttpClientModule,
  
    FormsModule,
    HttpClientModule,
    FormsModule,
    ReactiveFormsModule,
    MatSliderModule,
    MatToolbarModule,
     routing],


     
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule {}