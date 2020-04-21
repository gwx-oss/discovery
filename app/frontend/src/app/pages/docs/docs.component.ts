import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { SearchService } from '../search/search.service';
declare let API_HOST: string;
declare let SAM_API_KEY: string;
// declare let $: any;
@Component({
  templateUrl: './../../../docs/build/html/docs/index.html',
  styleUrls: ['./docs.component.css']
})
export class DocsComponent implements OnInit {
  constructor() {}

  ngOnInit() {}
}
