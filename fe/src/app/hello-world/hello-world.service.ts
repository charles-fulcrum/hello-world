import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class HelloWorldService {
  constructor(private http: HttpClient) {}

  getHelloWorld() {
    return firstValueFrom(this.http.get('/helloworld'));
  }

  postNewHelloWorld() {
    return firstValueFrom(
      this.http.post('/helloworld/new', {
        helloWorld: 'new hello world',
      })
    );
  }
}
