 

import { Component, OnInit } from '@angular/core';
import { DataService } from '../../services/data.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-permission-management',
  templateUrl: './permission-management.component.html',
  styleUrls: ['./permission-management.component.css']
})
export class PermissionManagementComponent implements OnInit {
  roles: any[] = [];
  permissions: any[] = [];
  permissionsMatrix: any = {};
  
  constructor(private dataService: DataService, private router: Router) { }
  
  ngOnInit(): void {
    this.loadPermissionsMatrix();
  }
  
  loadPermissionsMatrix(): void {
    this.dataService.getPermissionsMatrix().subscribe(data => {
      this.roles = data.roles;
      this.permissions = data.permissions;
      this.permissionsMatrix = data.matrix;
    });
  }
  
  updatePermission(roleId: number, permId: number, event: any): void {
    const isAllowed = event.target.checked;
    this.permissionsMatrix[roleId][permId].is_allowed = isAllowed;
  }
  

  saveChanges(): void {
    const allUpdates: { [key: number]: { [key: number]: boolean } } = {};
    
                     
    for (const roleId in this.permissionsMatrix) {
      if (this.permissionsMatrix.hasOwnProperty(roleId)) {
        allUpdates[Number(roleId)] = {};
        for (const permId in this.permissionsMatrix[roleId]) {
          if (this.permissionsMatrix[roleId].hasOwnProperty(permId)) {
            allUpdates[Number(roleId)][Number(permId)] = this.permissionsMatrix[roleId][permId].is_allowed;
          }
        }
      }
    }

    let successCount = 0;
    let errorCount = 0;
    const roleIds = Object.keys(allUpdates);
    if (roleIds.length === 0) {
      alert('No changes to save.');
      return;                               
    }
    roleIds.forEach(roleId => {
      this.dataService.updatePermissions(Number(roleId), allUpdates[Number(roleId)])
        .subscribe(response => {
          successCount++;
          if (successCount + errorCount === roleIds.length) {
            if (errorCount === 0) {
              alert('Permissions updated successfully!');
            } else {
              alert('Some permissions failed to update.');
            }
          }
        }, error => {
          errorCount++;
          console.error(`Error updating permissions for role ${roleId}:`, error);
          if (successCount + errorCount === roleIds.length) {
            alert('Some permissions failed to update.');
          }
        });
    });
  }

  
  
  goBack(): void {
    this.router.navigate(['/users']); 
  }
}