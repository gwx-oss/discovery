import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { SearchService } from '../search/search.service';
declare let API_HOST: string;
// declare let $: any;
@Component({
  templateUrl: './about.component.html',
  styleUrls: ['./about.component.css']
})
export class AboutComponent implements OnInit {
  sam_load_date;
  fpds_load_date;
  loading = true;
  error_message;
  constructor(private httpClient: HttpClient,  private searchService: SearchService) {}

  ngOnInit() {
    let apiUrl = API_HOST + '/api/metadata/';
    if(API_HOST.indexOf('localhost') === -1) {
      apiUrl = this.searchService.getAPIUrl();
    } 
    
    this.httpClient.get(apiUrl)
      .subscribe(data => {
        this.loading = false;
        this.sam_load_date = data['sam_load_date'];
        this.fpds_load_date = data['fpds_load_date'];
      });
  }
}
