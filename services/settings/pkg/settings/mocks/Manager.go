// Code generated by mockery v2.14.0. DO NOT EDIT.

package mocks

import (
	mock "github.com/stretchr/testify/mock"

	v0 "github.com/owncloud/ocis/v2/protogen/gen/ocis/messages/settings/v0"
)

// Manager is an autogenerated mock type for the Manager type
type Manager struct {
	mock.Mock
}

// AddSettingToBundle provides a mock function with given fields: bundleID, setting
func (_m *Manager) AddSettingToBundle(bundleID string, setting *v0.Setting) (*v0.Setting, error) {
	ret := _m.Called(bundleID, setting)

	var r0 *v0.Setting
	if rf, ok := ret.Get(0).(func(string, *v0.Setting) *v0.Setting); ok {
		r0 = rf(bundleID, setting)
	} else {
		if ret.Get(0) != nil {
			r0 = ret.Get(0).(*v0.Setting)
		}
	}

	var r1 error
	if rf, ok := ret.Get(1).(func(string, *v0.Setting) error); ok {
		r1 = rf(bundleID, setting)
	} else {
		r1 = ret.Error(1)
	}

	return r0, r1
}

// ListBundles provides a mock function with given fields: bundleType, bundleIDs
func (_m *Manager) ListBundles(bundleType v0.Bundle_Type, bundleIDs []string) ([]*v0.Bundle, error) {
	ret := _m.Called(bundleType, bundleIDs)

	var r0 []*v0.Bundle
	if rf, ok := ret.Get(0).(func(v0.Bundle_Type, []string) []*v0.Bundle); ok {
		r0 = rf(bundleType, bundleIDs)
	} else {
		if ret.Get(0) != nil {
			r0 = ret.Get(0).([]*v0.Bundle)
		}
	}

	var r1 error
	if rf, ok := ret.Get(1).(func(v0.Bundle_Type, []string) error); ok {
		r1 = rf(bundleType, bundleIDs)
	} else {
		r1 = ret.Error(1)
	}

	return r0, r1
}

// ListPermissionsByResource provides a mock function with given fields: resource, roleIDs
func (_m *Manager) ListPermissionsByResource(resource *v0.Resource, roleIDs []string) ([]*v0.Permission, error) {
	ret := _m.Called(resource, roleIDs)

	var r0 []*v0.Permission
	if rf, ok := ret.Get(0).(func(*v0.Resource, []string) []*v0.Permission); ok {
		r0 = rf(resource, roleIDs)
	} else {
		if ret.Get(0) != nil {
			r0 = ret.Get(0).([]*v0.Permission)
		}
	}

	var r1 error
	if rf, ok := ret.Get(1).(func(*v0.Resource, []string) error); ok {
		r1 = rf(resource, roleIDs)
	} else {
		r1 = ret.Error(1)
	}

	return r0, r1
}

// ListRoleAssignments provides a mock function with given fields: accountUUID
func (_m *Manager) ListRoleAssignments(accountUUID string) ([]*v0.UserRoleAssignment, error) {
	ret := _m.Called(accountUUID)

	var r0 []*v0.UserRoleAssignment
	if rf, ok := ret.Get(0).(func(string) []*v0.UserRoleAssignment); ok {
		r0 = rf(accountUUID)
	} else {
		if ret.Get(0) != nil {
			r0 = ret.Get(0).([]*v0.UserRoleAssignment)
		}
	}

	var r1 error
	if rf, ok := ret.Get(1).(func(string) error); ok {
		r1 = rf(accountUUID)
	} else {
		r1 = ret.Error(1)
	}

	return r0, r1
}

// ListValues provides a mock function with given fields: bundleID, accountUUID
func (_m *Manager) ListValues(bundleID string, accountUUID string) ([]*v0.Value, error) {
	ret := _m.Called(bundleID, accountUUID)

	var r0 []*v0.Value
	if rf, ok := ret.Get(0).(func(string, string) []*v0.Value); ok {
		r0 = rf(bundleID, accountUUID)
	} else {
		if ret.Get(0) != nil {
			r0 = ret.Get(0).([]*v0.Value)
		}
	}

	var r1 error
	if rf, ok := ret.Get(1).(func(string, string) error); ok {
		r1 = rf(bundleID, accountUUID)
	} else {
		r1 = ret.Error(1)
	}

	return r0, r1
}

// ReadBundle provides a mock function with given fields: bundleID
func (_m *Manager) ReadBundle(bundleID string) (*v0.Bundle, error) {
	ret := _m.Called(bundleID)

	var r0 *v0.Bundle
	if rf, ok := ret.Get(0).(func(string) *v0.Bundle); ok {
		r0 = rf(bundleID)
	} else {
		if ret.Get(0) != nil {
			r0 = ret.Get(0).(*v0.Bundle)
		}
	}

	var r1 error
	if rf, ok := ret.Get(1).(func(string) error); ok {
		r1 = rf(bundleID)
	} else {
		r1 = ret.Error(1)
	}

	return r0, r1
}

// ReadPermissionByID provides a mock function with given fields: permissionID, roleIDs
func (_m *Manager) ReadPermissionByID(permissionID string, roleIDs []string) (*v0.Permission, error) {
	ret := _m.Called(permissionID, roleIDs)

	var r0 *v0.Permission
	if rf, ok := ret.Get(0).(func(string, []string) *v0.Permission); ok {
		r0 = rf(permissionID, roleIDs)
	} else {
		if ret.Get(0) != nil {
			r0 = ret.Get(0).(*v0.Permission)
		}
	}

	var r1 error
	if rf, ok := ret.Get(1).(func(string, []string) error); ok {
		r1 = rf(permissionID, roleIDs)
	} else {
		r1 = ret.Error(1)
	}

	return r0, r1
}

// ReadPermissionByName provides a mock function with given fields: name, roleIDs
func (_m *Manager) ReadPermissionByName(name string, roleIDs []string) (*v0.Permission, error) {
	ret := _m.Called(name, roleIDs)

	var r0 *v0.Permission
	if rf, ok := ret.Get(0).(func(string, []string) *v0.Permission); ok {
		r0 = rf(name, roleIDs)
	} else {
		if ret.Get(0) != nil {
			r0 = ret.Get(0).(*v0.Permission)
		}
	}

	var r1 error
	if rf, ok := ret.Get(1).(func(string, []string) error); ok {
		r1 = rf(name, roleIDs)
	} else {
		r1 = ret.Error(1)
	}

	return r0, r1
}

// ReadSetting provides a mock function with given fields: settingID
func (_m *Manager) ReadSetting(settingID string) (*v0.Setting, error) {
	ret := _m.Called(settingID)

	var r0 *v0.Setting
	if rf, ok := ret.Get(0).(func(string) *v0.Setting); ok {
		r0 = rf(settingID)
	} else {
		if ret.Get(0) != nil {
			r0 = ret.Get(0).(*v0.Setting)
		}
	}

	var r1 error
	if rf, ok := ret.Get(1).(func(string) error); ok {
		r1 = rf(settingID)
	} else {
		r1 = ret.Error(1)
	}

	return r0, r1
}

// ReadValue provides a mock function with given fields: valueID
func (_m *Manager) ReadValue(valueID string) (*v0.Value, error) {
	ret := _m.Called(valueID)

	var r0 *v0.Value
	if rf, ok := ret.Get(0).(func(string) *v0.Value); ok {
		r0 = rf(valueID)
	} else {
		if ret.Get(0) != nil {
			r0 = ret.Get(0).(*v0.Value)
		}
	}

	var r1 error
	if rf, ok := ret.Get(1).(func(string) error); ok {
		r1 = rf(valueID)
	} else {
		r1 = ret.Error(1)
	}

	return r0, r1
}

// ReadValueByUniqueIdentifiers provides a mock function with given fields: accountUUID, settingID
func (_m *Manager) ReadValueByUniqueIdentifiers(accountUUID string, settingID string) (*v0.Value, error) {
	ret := _m.Called(accountUUID, settingID)

	var r0 *v0.Value
	if rf, ok := ret.Get(0).(func(string, string) *v0.Value); ok {
		r0 = rf(accountUUID, settingID)
	} else {
		if ret.Get(0) != nil {
			r0 = ret.Get(0).(*v0.Value)
		}
	}

	var r1 error
	if rf, ok := ret.Get(1).(func(string, string) error); ok {
		r1 = rf(accountUUID, settingID)
	} else {
		r1 = ret.Error(1)
	}

	return r0, r1
}

// RemoveRoleAssignment provides a mock function with given fields: assignmentID
func (_m *Manager) RemoveRoleAssignment(assignmentID string) error {
	ret := _m.Called(assignmentID)

	var r0 error
	if rf, ok := ret.Get(0).(func(string) error); ok {
		r0 = rf(assignmentID)
	} else {
		r0 = ret.Error(0)
	}

	return r0
}

// RemoveSettingFromBundle provides a mock function with given fields: bundleID, settingID
func (_m *Manager) RemoveSettingFromBundle(bundleID string, settingID string) error {
	ret := _m.Called(bundleID, settingID)

	var r0 error
	if rf, ok := ret.Get(0).(func(string, string) error); ok {
		r0 = rf(bundleID, settingID)
	} else {
		r0 = ret.Error(0)
	}

	return r0
}

// WriteBundle provides a mock function with given fields: bundle
func (_m *Manager) WriteBundle(bundle *v0.Bundle) (*v0.Bundle, error) {
	ret := _m.Called(bundle)

	var r0 *v0.Bundle
	if rf, ok := ret.Get(0).(func(*v0.Bundle) *v0.Bundle); ok {
		r0 = rf(bundle)
	} else {
		if ret.Get(0) != nil {
			r0 = ret.Get(0).(*v0.Bundle)
		}
	}

	var r1 error
	if rf, ok := ret.Get(1).(func(*v0.Bundle) error); ok {
		r1 = rf(bundle)
	} else {
		r1 = ret.Error(1)
	}

	return r0, r1
}

// WriteRoleAssignment provides a mock function with given fields: accountUUID, roleID
func (_m *Manager) WriteRoleAssignment(accountUUID string, roleID string) (*v0.UserRoleAssignment, error) {
	ret := _m.Called(accountUUID, roleID)

	var r0 *v0.UserRoleAssignment
	if rf, ok := ret.Get(0).(func(string, string) *v0.UserRoleAssignment); ok {
		r0 = rf(accountUUID, roleID)
	} else {
		if ret.Get(0) != nil {
			r0 = ret.Get(0).(*v0.UserRoleAssignment)
		}
	}

	var r1 error
	if rf, ok := ret.Get(1).(func(string, string) error); ok {
		r1 = rf(accountUUID, roleID)
	} else {
		r1 = ret.Error(1)
	}

	return r0, r1
}

// WriteValue provides a mock function with given fields: value
func (_m *Manager) WriteValue(value *v0.Value) (*v0.Value, error) {
	ret := _m.Called(value)

	var r0 *v0.Value
	if rf, ok := ret.Get(0).(func(*v0.Value) *v0.Value); ok {
		r0 = rf(value)
	} else {
		if ret.Get(0) != nil {
			r0 = ret.Get(0).(*v0.Value)
		}
	}

	var r1 error
	if rf, ok := ret.Get(1).(func(*v0.Value) error); ok {
		r1 = rf(value)
	} else {
		r1 = ret.Error(1)
	}

	return r0, r1
}

type mockConstructorTestingTNewManager interface {
	mock.TestingT
	Cleanup(func())
}

// NewManager creates a new instance of Manager. It also registers a testing interface on the mock and a cleanup function to assert the mocks expectations.
func NewManager(t mockConstructorTestingTNewManager) *Manager {
	mock := &Manager{}
	mock.Mock.Test(t)

	t.Cleanup(func() { mock.AssertExpectations(t) })

	return mock
}