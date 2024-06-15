import 'package:blog_app/controllers/organization_controller.dart';
import 'package:blog_app/models/organization/es_organization.dart';
import 'package:blog_app/utils/struct_response.dart';

class OrganizationService {
  Future<EsOrganization> getOrganizations() async {
    StructResponse serviceResponse = StructResponse();
    EsOrganization esOrganization = await OrganizationController.getAll(5, 1);
    serviceResponse.response = esOrganization;

    return esOrganization;
  }
}
