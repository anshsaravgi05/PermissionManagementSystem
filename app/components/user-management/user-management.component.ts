import { Component, OnInit } from '@angular/core';
import { DataService } from '../../services/data.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-user-management',
  templateUrl: './user-management.component.html',
  styleUrls: ['./user-management.component.css']
})
export class UserManagementComponent implements OnInit {
  users: any[] = [];
  roles: any[] = [];
  selectedRole: string = 'All Users';

  constructor(private dataService: DataService, private router: Router) { }

  ngOnInit(): void {
    this.loadUsers();
    this.loadRoles();
  }

  loadUsers(roleId: number | null = null): void {
    this.dataService.getUsers(roleId).subscribe(data => {
      this.users = data;
    });
  }

  loadRoles(): void {
    this.dataService.getPermissionsMatrix().subscribe(data => {
      this.roles = data.roles;
    });
  }

  filterByRole(roleName: string, roleId: number | null = null): void {
    this.selectedRole = roleName;
    this.loadUsers(roleId);
  }

  getInitial(name: string): string {
    return name.charAt(0).toUpperCase();
  }

  goToPermissions(): void {
    this.router.navigate(['/permissions']);
  }
}