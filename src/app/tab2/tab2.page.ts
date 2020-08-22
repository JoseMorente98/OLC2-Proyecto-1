import { Component } from '@angular/core';

@Component({
  selector: 'app-tab2',
  templateUrl: 'tab2.page.html',
  styleUrls: ['tab2.page.scss']
})
export class Tab2Page {
  itemSelect:any = 'Error'
  constructor() {}

  segmentChanged(ev: any) {
    console.log('Segment changed', ev);
    this.itemSelect = ev.detail.value;
  }

}
