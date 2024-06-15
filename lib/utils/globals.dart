// ignore_for_file: non_constant_identifier_names

//! tagglobal TagGlobal TAGGLOBAL globaltag GlobalTag GLOBALTAG

import 'dart:core';

///!  System
String systemName = 'Kananfleet';
String systemVersion = 'v2.2024.03.15.01';

///!  User
String userAvatar = '';

///!  Responsive Screen
bool responsiveScreenOk = true;
double WIDTH_MIN = 940;
double HEIGHT_MIN = 500;

///! medidas del celular Rodrigo
// double WIDTH_MIN = 839;
// double HEIGHT_MIN = 376;

///!  Language
String myLang = 'es';
int myLanId = 1;
var lang = <String, Map<String, String>>{
  'en': {},
  'es': {},
};

///!  Document Manager
int MAX_SIZE_MB_DOCUMENT = 8;
int MAX_SIZE_MB_IMAGE = 8;

///!  Notice Privacy
var langNoticePrivacy = <String, Map<String, String>>{
  'es': {
    'login_notice_privacy_close': 'Cerrar',
    'login_notice_privacy_title': 'POLÍTICAS DE PRIVACIDAD',
    'login_notice_privacy_content':
        '\n    De acuerdo a lo Previsto en la "Ley Federal de Protección de Datos Personales", declara ETECNO SA DE CV, ser una empresa legalmente constituida de conformidad con las leyes mexicanas, con domicilio en Calle 17 No. 474 por 20 y 22 Col. Altabrisa, C.P. 97130 Mérida, Yucatán, México; y como responsable del tratamiento de sus datos personales, hace de su conocimiento que la información de nuestros clientes es tratada estrictamente confidencial por lo que al proporcionar sus datos personales, tales como:\n•Nombre Completo\n• Dirección\n• Registro Federal de Contribuyentes\n• Teléfonos de Hogar, Oficina y móviles\n• Correo Electrónico\n Estos serán utilizados única y exclusivamente para los siguientes fines: \n• Facturación\n* Campañas de Publicidad\n• Campañas de Fidelidad \n• Información y Prestación de Servicios \n• Actualización de la Base de Datos \n• Cualquier finalidad análoga o compatible con las anteriores \nEn el caso de Datos sensibles, tales como:\n• Datos Financieros (Ingresos, Estados de Cuentas, y además relacionados) \n• Datos Patrimoniales (Bienes Materiales, Inmuebles, y demás relacionados)\n• Datos Personales (Cónyuge, Estado Civil, Nacionalidad, Educación, Hijos, y demás relacionados) \n• Referencias familiares y no familiares (Nombre, Dirección, teléfono, Relación, etc.) Estos serán utilizados única y exclusivamente para los siguientes fines:\n• Investigación y/o Obtención de Créditos ante las instituciones Financieras\n• Cualquier finalidad análoga o compatible con la anterior \n\nPara prevenir el acceso no autorizado a sus datos personales y con el fin de asegurar que la información sea utilizada para los fines establecidos en este aviso de privacidad, hemos establecido diversos procedimientos con la finalidad de evitar el uso o divulgación no autorizados de sus datos, permitiéndonos tratarlos debidamente.\n\n Así mismo, le informamos que sus datos personales pueden ser transmitidos para ser tratados por personas distintas a esta empresa. Todos sus datos personales son tratados de acuerdo a la  legislación aplicable y vigente en el país, por ello le informamos que usted tiene todo momento los derechos de acceder, rectificar, cancelar u oponerse al tratamiento que le damos a sus datos personales; derecho que podrá hacer valer a través del Área de Privacidad encargada de la seguridad de sus datos personales en el Teléfono +52 (999) 9306745 o por medio del correo electrónico: info@administraflotilla.com\n\n A través de esos canales usted podrá actualizar sus datos y especificar el medio por el cual desea recibir información, ya que en caso de no contar con esta especificación de su parte, ETECNO, SA DE CV establecerá libremente el canal que considere pertinente para enviarle información. \n\nEste aviso de privacidad podrá ser modificado por ETECNO SA DE CV, dichas modificaciones serán oportunamente informadas a través de correo electrónico, teléfono, o cualquier otro medio de comunicación que ETECNO SA DE CV determine para tal efecto. \n\nÚltima fecha de modificación: 1 Mayo de 2023\n\n ATENTAMENTE\n ETECNO SA DE CV\n\n',
  },
  'en': {
    'login_notice_privacy_close': 'Close',
    'login_notice_privacy_title': 'PRIVACY POLICIES',
    'login_notice_privacy_content':
        '\n In accordance with the provisions of the "Federal Law for the Protection of Personal Data", ETECNO SA DE CV declares to be a company legally constituted in accordance with Mexican laws, with address at Calle 17 No. 474 by 20 and 22 Col Altabrisa, C.P. 97130 Merida, Yucatan, Mexico; and as responsible for the processing of your personal data, you are informed that the information of our clients is treated strictly confidential, so when providing your personal data, such as:\n• Full Name\n• Address\n• Federal Taxpayer Registry\n• Home, Office and mobile telephones\n• Email\n These will be used solely and exclusively for the following purposes: \n• Billing\n• Advertising Campaigns\n• Loyalty Campaigns \n• Information and Provision of Services \n• Updating of the Database \n• Any analogous or compatible purpose with the previous ones \nIn the case of sensitive Data, such as:\n• Financial Data (Income, Account Statements, and also related) \n• Patrimonial Data (Material Assets, Real Estate, and other related) \n• Personal Data (Spouse, Marital Status, Nationality, Education, Children, and other related) \n• Family and non-family references (Name, Address, telephone, Relationship, etc.) These will be used solely and exclusively for the following purposes:\n• Investigation and/or Obtaining Credits from Financial Institutions\n• Any analogous or compatible purpose with the previous one \n\nTo prevent unauthorized access to your personal data and in order to ensure that the information is used for the purposes established in this privacy notice, we have established various procedures in order to prevent the unauthorized use or disclosure of your data, allowing us to treat them duly.\n\n Likewise, we inform you that your personal data may be transmitted to be processed by persons other than this company. All your personal data is treated in accordance with the applicable and current legislation in the country, therefore we inform you that you have the right to access, rectify, cancel or oppose the treatment that we give to your personal data at all times; right that you can assert through the Privacy Area in charge of the security of your personal data on the Telephone +52 (999) 9306745 or by email: info@administraflotilla.com\n\nThrough these channels you You can update your data and specify the means by which you wish to receive information, since if you do not have this specification on your part, ETECNO, SA DE CV will freely establish the channel it deems pertinent to send you information. \n\nThis privacy notice may be modified by ETECNO SA DE CV, such modifications will be duly informed through email, telephone, or any other means of communication that ETECNO SA DE CV determines for this purpose. \n\nLast date of modification: May 1, 2023\n\n YOURS REALLY \n ETECNO SA DE CV\n\n'
  },
};

///!
///!  API URL
///!
//! Oficina - Dispositivo
//String urlAPIs = 'http://192.168.1.115:7002';
//String urlAPIs = 'http://192.168.100.32:7002';
//
//! Casa
//String urlAPIs = 'http://192.168.0.12:7002';
//
//! Compu Vic
//String urlAPIs = 'http://26.222.11.66:7002';
//
//! Publicaciones
//String urlAPIs = 'https://webapisilodisa.administraflotilla.com';
//String urlAPIs = 'http://localhost:3000';
//
String urlAPIs = 'https://blog-api-v2-production.up.railway.app';
//String urlAPIs = 'https://kananfleet2.administraflotilla.com';
//String urlAPIs = 'http://localhost:7002';
