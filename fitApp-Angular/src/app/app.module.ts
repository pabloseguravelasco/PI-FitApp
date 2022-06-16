import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

import { HttpClientModule } from '@angular/common/http';
import { MaterialImportsModule } from './modules/material-imports.module';
import { ExerciseListComponent } from './components/exercise-list/exercise-list.component';
import { ExerciseItemComponent } from './components/exercise-item/exercise-item.component';
import { FlexLayoutModule } from '@angular/flex-layout';
import { NgCircleProgressModule } from 'ng-circle-progress';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { LoginComponent } from './components/login/login.component';
import { DietListComponent } from './components/diet-list/diet-list.component';
import { DietItemComponent } from './components/diet-item/diet-item.component';
import { SideMenuComponent } from './shared/side-menu/side-menu.component';
import { DialogExerciseDetailComponent } from './components/dialogs/dialog-exercise-detail/dialog-exercise-detail.component';



@NgModule({
  declarations: [
    AppComponent,
    ExerciseListComponent,
    ExerciseItemComponent,
    DietListComponent,
    DietItemComponent,
    LoginComponent,
    SideMenuComponent, 
    DialogExerciseDetailComponent

   
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    MaterialImportsModule,
    HttpClientModule,
    FlexLayoutModule,
    FormsModule,
    ReactiveFormsModule,
    
    NgCircleProgressModule.forRoot({
      "radius": 25,
      "outerStrokeGradient": true,
      "outerStrokeWidth": 5,
      "outerStrokeColor": "#4882c2",
      "outerStrokeGradientStopColor": "#53a9ff",
      "innerStrokeWidth": 0,
      "title": "Rate",
      "titleColor": "#FFFFFF",
      "titleFontSize": "15",
      "titleFontWeight": "bold",
      "showSubtitle": false,
      "animateTitle": true,
      "animationDuration": 1000,
      "showUnits": false,
      "showBackground": true,
      "backgroundColor": "#000000"
    })
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
