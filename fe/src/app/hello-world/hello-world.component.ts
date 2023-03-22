import { Component } from '@angular/core';
import { HelloWorldService } from './hello-world.service';

@Component({
  selector: 'app-hello-world',
  templateUrl: './hello-world.component.html',
  styleUrls: ['./hello-world.component.scss'],
})
export class HelloWorldComponent {
  helloWorld?: Object = undefined;
  newHelloWorld?: Object = undefined;

  constructor(private helloWorldService: HelloWorldService) { }

  async ngOnInit() {
    const helloWorldResponse = await this.helloWorldService.getHelloWorld();
    this.helloWorld = JSON.stringify(helloWorldResponse);
  }

  async postNewHelloWorld() {
    const newHelloWorldResponse =
      await this.helloWorldService.postNewHelloWorld();
    this.newHelloWorld = JSON.stringify(newHelloWorldResponse);
  }
}
