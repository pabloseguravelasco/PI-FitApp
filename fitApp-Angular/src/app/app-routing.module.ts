import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { DietListComponent } from './components/diet-list/diet-list.component';
import { ExerciseListComponent } from './components/exercise-list/exercise-list.component';
import { LoginComponent } from './components/login/login.component';
import { AuthGuard } from './services/auth.guard';
import { SideMenuComponent } from './shared/side-menu/side-menu.component';

const routes: Routes = [
  


  { path: 'exercise/list', component: ExerciseListComponent, /*canActivate: [AuthGuard]*/ },
  {path: 'diet/list', component: DietListComponent, /*canActivate: [AuthGuard]*/ },
  {path: '', pathMatch: 'full', component: LoginComponent},

  
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
