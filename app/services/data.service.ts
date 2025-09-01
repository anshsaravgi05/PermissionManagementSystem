
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class DataService {
  
  private apiUrl = 'http://localhost/permission'; 

  constructor(private http: HttpClient) { }

  getUsers(roleId: number | null = null): Observable<any[]> {
    const url = roleId ? `${this.apiUrl}/get_users.php?role_id=${roleId}` : `${this.apiUrl}/get_users.php`;
    return this.http.get<any[]>(url);
  }

  getRoles(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/get_roles_permissions.php`).pipe(
      map((res: any) => res.roles)
    );
  }

  getPermissionsMatrix(): Observable<any> {
    return this.http.get<any>(`${this.apiUrl}/get_roles_permissions.php`);
  }

  updatePermissions(roleId: number, updates: { [key: number]: boolean }): Observable<any> {
    const body = { role_id: roleId, updates: updates };
    return this.http.post<any>(`${this.apiUrl}/update_permissions.php?role_id=${roleId}`, body);
  }
}