import { Component, OnInit } from '@angular/core';
import { Gasolinera, Municipio, Provincia } from 'src/app/models/interfaces/gasolinera';
import { GasolineraService } from 'src/app/services/gasolinera.service';

@Component({
  selector: 'app-gasolinera-list',
  templateUrl: './gasolinera-list.component.html',
  styleUrls: ['./gasolinera-list.component.css']
})
export class GasolineraListComponent implements OnInit {

  listaGasolineras: Gasolinera[] =[];
  provinciaArray!: string[];
  listaGasolinerasComplete: Gasolinera[] =[];
  listaProvincias: Provincia[] = [];
  precioMin!: number;
  gasolinaType!:string;
  listaMunicipios: Municipio[] = [];
  mostrar!: boolean;
  municipio!:string
  

  constructor(private gasolineraService: GasolineraService) { }

  ngOnInit(): void {
    this.gasolineraService.getGasolinera().subscribe(resp => {
      this.listaGasolineras = this.gasolineraService.parseAnyToGasolineraResponse(JSON.stringify(resp));
      console.log(this.listaGasolineras);
      this.listaGasolinerasComplete = this.gasolineraService.parseAnyToGasolineraResponse(JSON.stringify(resp))
    });
      this.gasolineraService.getProvincias().subscribe(resp =>{
        this.listaProvincias = resp
        console.log(this.listaProvincias)
      })
  }


  filterByProvincia(){
    this.listaGasolineras = this.listaGasolinerasComplete
    if (this.listaGasolineras.length > 0){    
    let listaProvincias: Gasolinera[] = this.listaGasolineras.filter(provincia => this.provinciaArray.includes( provincia.idProvincia))
    this.listaGasolineras = listaProvincias;
    this.getMunicipiosById();
   
  }else{
    this.gasolineraService.getGasolinera();
  }

}

  filterByPrecio(){
    this.listaGasolineras = this.listaGasolinerasComplete
    if(this.gasolinaType.includes('precioGasoleoA')){
    let precioGasolina: Gasolinera[] = this.listaGasolineras.filter(precio => this.precioMin < Number.parseFloat(precio.precioGasoleoA.replace(',','.')))
    this.listaGasolineras = precioGasolina;
    }else if(this.gasolinaType.includes('precioGasolina95E9')){
    let precioGasolina: Gasolinera[] = this.listaGasolineras.filter(precio => this.precioMin < Number.parseFloat(precio.precioGasolina95E5.replace(',','.')))
    this.listaGasolineras = precioGasolina;
    }else{
    let precioGasolina: Gasolinera[] = this.listaGasolineras.filter(precio => this.precioMin < Number.parseFloat(precio.precioGasolina98E5.replace(',','.')))
    this.listaGasolineras = precioGasolina;
  }
}

  getMunicipiosById(){
  this.mostrar = true
  this.gasolineraService.getMunicipios(this.provinciaArray).subscribe(municipios => {
    this.listaMunicipios = municipios
    console.log(municipios)
  })
}

  filterByMunicipio(){
  this.listaGasolineras = this.listaGasolinerasComplete
  this.listaGasolineras = this.listaGasolineras.filter(gasolinera => this.municipio == gasolinera.municipio)
}


    removeFilter(){
    this.listaGasolineras = this.listaGasolinerasComplete
  }

  
}
