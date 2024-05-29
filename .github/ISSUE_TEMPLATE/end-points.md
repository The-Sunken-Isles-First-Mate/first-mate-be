---
name: End Points
about: Template for creating BE end points
title: "[BE] [brief feature description]"
labels: ''
assignees: ''

---

# [endpoint]

## Details
- This endpoint should follow the pattern of [VERB] [URI] and should return _____
- [any additional details on the endpoint (i.e. should also display party_member_count; if an invalid :id is passed in, a 404 status is returned...)]

## Happy Path
### Request: 
```
[VERB] [URI]
Content-Type: application/json  
Accept: application/json  
```

### Response: ``` status: 200 ```  
```
[expected json response]
```

## Sad Path
### Request:
```
[VERB] [URI (with details on sad path)]
Content-Type: application/json  
Accept: application/json  
```

### Response: ``` status: <error-code> ```  
```
[expected json response]
```

## Related/Dependent Tickets
- [link to related FE ticket]
