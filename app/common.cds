using { sap.ui.riskmanagement  as rm } from '../db/schema';

annotate rm.Risks with {
    ID          @title: 'Risk';
	title       @title: 'Title';
    owner       @title: 'Owner';
	prio        @title: 'Priority';
	descr       @title: 'Description';
	miti        @title: 'Mitigation';
	impact      @title: 'Impact';
}

annotate rm.Mitigations with {
	ID @(
		UI.Hidden,
		Common: { Text: descr }
	);
    owner        @title: 'Owner';
	descr        @title: 'Description';
}

annotate rm.Risks with {
	miti @(
		Common: {
			//show text, not id for mitigation in the context of risks
			Text: miti.descr  , TextArrangement: #TextOnly,
			ValueList: {
				Label: 'Mitigations',
				CollectionPath: 'Mitigations',
				Parameters: [
					{ $Type: 'Common.ValueListParameterInOut',
						LocalDataProperty: miti_ID,
						ValueListProperty: 'ID'
					},
					{ $Type: 'Common.ValueListParameterDisplayOnly',
						ValueListProperty: 'descr'
					}
				]
			}
		}
	);
}

annotate rm.BusinessPartners with {
	miti @(
		Common: {
			//show text, not id for mitigation in the context of risks
			Text: miti.descr  , TextArrangement: #TextOnly,
			ValueList: {
				Label: 'Business Partners',
				CollectionPath: 'BusinessPartners',
				Parameters: [
					{ $Type: 'Common.ValueListParameterInOut',
						LocalDataProperty: bp_BisinessPartner,
						ValueListProperty: 'BisinessPartner'
					},
					{ $Type: 'Common.ValueListParameterDisplayOnly',
						ValueListProperty: 'LastName'
					},
					{ $Type: 'Common.ValueListParameterDisplayOnly',
						ValueListProperty: 'FirstName'
					}                    
				]
			}
		}
	);
}

using from './risks/annotations';
using from './common';
