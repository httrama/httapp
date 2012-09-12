<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>Travel Itinerary Stage</fullName>
        <actions>
            <name>Call_Patient_48</name>
            <type>Task</type>
        </actions>
        <actions>
            <name>Call_Patient_Before_Departure</name>
            <type>Task</type>
        </actions>
        <actions>
            <name>Changes_Strategy</name>
            <type>Task</type>
        </actions>
        <actions>
            <name>Collect_Payment</name>
            <type>Task</type>
        </actions>
        <actions>
            <name>Start_Itinerary</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Treatment__c.Phase__c</field>
            <operation>equals</operation>
            <value>(3) Travel</value>
        </criteriaItems>
        <criteriaItems>
            <field>Treatment__c.Stage__c</field>
            <operation>equals</operation>
            <value>Travel Itinerary</value>
        </criteriaItems>
        <description>WF fires when the treatment enters Travel Itinerary Stage</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <tasks>
        <fullName>Call_Patient_48</fullName>
        <assignedToType>owner</assignedToType>
        <description>1. call patient within 48 hours (48 hour initial contact)</description>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Call Patient 48</subject>
    </tasks>
    <tasks>
        <fullName>Call_Patient_Before_Departure</fullName>
        <assignedToType>owner</assignedToType>
        <description>3. call patient night before departure (pre-arrival call)</description>
        <dueDateOffset>-1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Call Patient Before Departure</subject>
    </tasks>
    <tasks>
        <fullName>Changes_Strategy</fullName>
        <assignedToType>owner</assignedToType>
        <description>5. Changes Strategy (update strategy to Travel Complete)</description>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Changes Strategy</subject>
    </tasks>
    <tasks>
        <fullName>Collect_Payment</fullName>
        <assignedToType>owner</assignedToType>
        <description>4. collect pay (payment collection)</description>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Collect Payment</subject>
    </tasks>
    <tasks>
        <fullName>Start_Itinerary</fullName>
        <assignedToType>owner</assignedToType>
        <description>2. start itinerary (itinerary in progress)</description>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Start Itinerary</subject>
    </tasks>
</Workflow>
