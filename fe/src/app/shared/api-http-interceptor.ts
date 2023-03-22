import { HttpHandler, HttpInterceptor, HttpRequest } from "@angular/common/http";
import { Injectable } from "@angular/core";

@Injectable()
export class ApiHttpInterceptor implements HttpInterceptor {
  intercept(req: HttpRequest<unknown>, next: HttpHandler) {
    const apiRequest = req.clone({ url: `http://localhost:5001/api${req.url}` });
    return next.handle(apiRequest);
  }
}
