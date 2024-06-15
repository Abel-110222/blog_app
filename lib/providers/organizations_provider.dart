import 'package:flutter/material.dart';
import 'package:blog_app/models/organization/es_organization.dart';
import 'package:blog_app/models/organization/organization_model.dart';
import 'package:blog_app/services_providers/organization_services.dart';

class OrganizationsProvider extends ChangeNotifier {
  late EsOrganization _organizations = EsOrganization();
  late List<OrganizationModel> _organizationList = []; // Lista para almacenar las organizaciones

  Future<EsOrganization> getOrganizations() async {
    if (_organizations.organizations != null && _organizations.organizations!.isNotEmpty) {
      return _organizations;
    }
    var service = OrganizationService();
    _organizations = await service.getOrganizations();

    _organizationList = _organizations.organizations!;

    notifyListeners();
    return _organizations;
  }

  List<OrganizationModel> get organizationList => _organizationList;

  Future<EsOrganization> refreshOrganizations() async {
    var service = OrganizationService();
    _organizations = await service.getOrganizations();

    notifyListeners();
    return _organizations;
  }
}
