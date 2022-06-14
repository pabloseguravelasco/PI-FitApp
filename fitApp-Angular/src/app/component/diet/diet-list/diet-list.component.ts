import { Component, OnInit } from '@angular/core';
import { Diet, Municipio, Provincia } from 'src/app/models/interfaces/diet';
import { DietService } from 'src/app/services/diet.service';

@Component({
  selector: 'app-diet-list',
  templateUrl: './diet-list.component.html',
  styleUrls: ['./diet-list.component.css']
})
export class DietListComponent implements OnInit {

  listaDiets: Diet[] =[];
  provinciaArray!: string[];
  listaDietsComplete: Diet[] =[];
  listaProvincias: Provincia[] = [];
  precioMin!: number;
  gasolinaType!:string;
  listaMunicipios: Municipio[] = [];
  mostrar!: boolean;
  municipio!:string
  

  constructor(private dietService: DietService) { }

  ngOnInit(): void {
    this.dietService.getDiet().subscribe(resp => {
      this.listaDiets = this.dietService.parseAnyToDietResponse(JSON.stringify(resp));
      console.log(this.listaDiets);
      this.listaDietsComplete = this.dietService.parseAnyToDietResponse(JSON.stringify(resp))
    });
      this.dietService.getProvincias().subscribe(resp =>{
        this.listaProvincias = resp
        console.log(this.listaProvincias)
      })
  }


  filterByProvincia(){
    this.listaDiets = this.listaDietsComplete
    if (this.listaDiets.length > 0){    
    let listaProvincias: Diet[] = this.listaDiets.filter(provincia => this.provinciaArray.includes( provincia.idProvincia))
    this.listaDiets = listaProvincias;
    this.getMunicipiosById();
   
  }else{
    this.dietService.getDiet();
  }

}

  filterByPrecio(){
    this.listaDiets = this.listaDietsComplete
    if(this.gasolinaType.includes('precioGasoleoA')){
    let precioGasolina: Diet[] = this.listaDiets.filter(precio => this.precioMin < Number.parseFloat(precio.precioGasoleoA.replace(',','.')))
    this.listaDiets = precioGasolina;
    }else if(this.gasolinaType.includes('precioGasolina95E9')){
    let precioGasolina: Diet[] = this.listaDiets.filter(precio => this.precioMin < Number.parseFloat(precio.precioGasolina95E5.replace(',','.')))
    this.listaDiets = precioGasolina;
    }else{
    let precioGasolina: Diet[] = this.listaDiets.filter(precio => this.precioMin < Number.parseFloat(precio.precioGasolina98E5.replace(',','.')))
    this.listaDiets = precioGasolina;
  }
}

  getMunicipiosById(){
  this.mostrar = true
  this.dietService.getMunicipios(this.provinciaArray).subscribe(municipios => {
    this.listaMunicipios = municipios
    console.log(municipios)
  })
}

  filterByMunicipio(){
  this.listaDiets = this.listaDietsComplete
  this.listaDiets = this.listaDiets.filter(diet => this.municipio == diet.municipio)
}


    removeFilter(){
    this.listaDiets = this.listaDietsComplete
  }

  
}
