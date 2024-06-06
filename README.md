# The Sunken Isles First Mate

## Table of Contents
- [Getting Started](#getting-started)
- [Project Description](#project-description)
- [External APIs and Services](#external-apis-and-services)
- [End Points](#end-points)
- [Contributors](#contributors)
- [FE Repo](https://github.com/The-Sunken-Isles-First-Mate/first-mate-fe)
- [Deployment (INSERT HEROKU LINK HERE)

## Getting Started
### Versions
- Ruby: 3.2.2
- Rails: 7.1.3

## Project Description

The Sunken Isles First Mate is a companion app designed to support some additional functionality built-in to the Sunken Isles DnD Campaign.  The Dungeon Master (DM) of a Sunken Isles campaign can create a campaign in our app which the party-members can then join and chreate their character.  From here, the party-members will decide on how to assign work to their villagers, what resources to collect, and what items to build.  At the end of an in-game week, the DM will go to their campaign management page, advance the week, and all of the exploration and crafting will be enacted and shown on the new summary page.  Now the DM can take this information into the next session, further expanding on the magical world of the Sunken Isles! 

This app was designed and built with a team of 5 developers as part of the [consultancy project](https://backend.turing.edu/module3/projects/consultancy/), from Turing School of Software and Design.

<details>
  <summary>Learning Goals for Project</summary>
- goal 1
- goal 2
- goal 3
</details>

<details>
  <summary>Setup</summary>
  1. Fork and/or Clone this Repo from GitHub.
  2. In your terminal use `$ git clone <ssh or https path>`.
  3. Change into the cloned directory using `$ cd example`.
  4. Install the gem packages using `$ bundle install`.
  5. Database Migrations can be set up by running: 
  ``` bash 
  $ rails rake db:{drop,create,migrate,seed}
  ```
</details>

<details>
  <summary>Testing</summary>

  Test using the terminal utilizing RSpec:

  ```bash
  $ bundle exec rspec spec/<follow directory path to test specific files>
  ```

  or test the whole suite with `$ bundle exec rspec`

  Test Results as of 6/6/24: INSERT HERE
</details>

<details>
  <summary>Database Schema</summary>
  ```
    INSERT SCHEMA HERE
  ```
</details>

## External APIs and Services
#### AWS S3 API
  - In our application, we leverage AWS S3 to manage user-uploaded image files. By storing these files in an S3 bucket, we effectively reduce the size of our database, containing only essential data. This approach is particularly beneficial given the potentially large sizes of image files and the hope that there will eventually be a large number of characters and character images. Storing them in an external database  This optimization enhances the efficiency of our database operations while ensuring the security and accessibility of our image assets. 

  - [AWS S3 documentation](https://aws.amazon.com/s3/)

#### GitHub OAuth
  - WRITE UP GH OAUTH DESCRIPTION HERE

  - [GitHub Documentation](INSERT LINK HERE)

#### DnD 5e SRD API
  - While limited in it's scope, the API provides all class and race data that we use in our character creation feature.  Unfortunately, there is a lot of missing information from the database, leading us to not use it as thoroughly as we expected.  There is talk in forums online that the API may be getting a major update soon, and if this is the case, we'd love to utilize the API for item creation and resources, especially if images are included in a future update.

  - [DnD 5e SRD API Documentation](https://5e-bits.github.io/docs/api)

## End Points
### User
<details>
<summary> Get One User </summary>

Request:

```http
GET /api/v1/users/:id
Content-Type: application/json
Accept: application/json
```

Body: 

```json
{
  user: {
    "username": 'randomusername',
    "token": '1jkfdsa9cj,32jjcnkldsluiouijkjfd'
    }
}
```

Response: `status: 200`

```json
{ 
  "data": {
    "id": "1",
    "type": "user"
    "attributes": {
       "id": "1",
       "username": "randomusername",
       "token": "1jkfdsa9cj,32jjcnkldsluiouijkjfd",
       "uid": "1"
    }
  }
}
```
</details>

### Campaign
<details>
<summary> Get One Campaign </summary>

Request:

```http
GET /api/v1/campaigns/:id
Content-Type: application/json
Accept: application/json
```

Response: `status: 200`

```json
{ 
  "data": {
    "id": "1",
    "type": "campaign"
    "attributes": {
       "name": "Turing Campaign",
       "week": 1,
       "animal_products": 2,
       "cloth": 0,
       "farmed_goods": 0,
       "food": 4,
       "foraged_goods": 1,
       "metal": 1,
       "monster_parts": 2,
       "stone": 1,
       "wood": 5,
       "villagers": 20
    }
  }
}
```
</details>

<details>
<summary> Create a Campaign </summary>

Request:

```http
POST /api/v1/campaigns
Content-Type: application/json
Accept: application/json
```

Body: 

```json
{
  "name": "Turing Campaign",
}
```

Response: `status: 201`

```json
{ 
  "data": {
    "id": "1",
    "type": "campaign"
    "attributes": {
       "name": "Turing Campaign",
       "week": 0,
       "animal_products": 0,
       "cloth": 0,
       "farmed_goods": 0,
       "food": 0,
       "foraged_goods": 0,
       "metal": 0,
       "monster_parts": 0,
       "stone": 0,
       "wood": 0,
       "villagers": 120
    }
  }
}
```
</details>

<details>
<summary> Update a Campaign </summary>

Request:

```http
PATCH /api/v1/campaigns/:id
Content-Type: application/json
Accept: application/json
```

Body: 

```json
{
  "week": 1,
  "cloth": 5,
  "villagers": 150
}
```

Response: `status: 200`

```json
{ 
  "data": {
    "id": "1",
    "type": "campaign"
    "attributes": {
       "name": "Turing Campaign",
       "week": 1,
       "animal_products": 0,
       "cloth": 5,
       "farmed_goods": 0,
       "food": 0,
       "foraged_goods": 0,
       "metal": 0,
       "monster_parts": 0,
       "stone": 0,
       "wood": 0,
       "villagers": 150
    }
  }
}
```
</details>

<details>
<summary> Get all Characters from a Campaign </summary>

Request:

```http
GET /api/v1/campaigns/:id/characters
Content-Type: application/json
Accept: application/json
```

Response: `status: 200`

```json
{ 
  "data": [{
    "id": "1",
    "type": "character"
    "attributes": {
       "name": "Cap'n Clirrk",
       "user_id": 1,
       "race": "human",
       "class": "bard",
       "image_url": UPDATE WITH HOW A URL SHOULD APPEAR
    },
    {"id": "2",
    "type": "character"
    "attributes": {
       "name": "Sambo",
       "user_id": 2,
       "race": "Ogre",
       "class": "Monk",
       "image_url": UPDATE WITH HOW A URL SHOULD APPEAR
    },
  ...,
  ...,
  }
}
```
</details>

<details>
<summary> Get all Items from a Campaign </summary>

Request:

```http
GET /api/v1/campaigns/:id/items
Content-Type: application/json
Accept: application/json
```

Response: `status: 200`

```json
{
  "data": [
    {
      "id": "1",
      "type": "campaign_item",
      "attributes": {
        "campaign_id": 1,
        "item_id": 1,
        "quantity_owned": 0
        },
      "relationships": {
        "campaign": {
          "data": {
            "id": "1",
            "type": "campaign"
          }
        },
        "item": {
          "data": {
            "id": "1",
            "type": "item"
          }
        }
      }
    },
    {
      "id": "2",
      "type": "campaign_item",
      "attributes": {
        "campaign_id": 1,
        "item_id": 2,
        "quantity_owned": 0
        },
      "relationships": {
        "campaign": {
          "data": {
            "id": "1",
            "type": "campaign"
          }
        },
        "item": {
          "data": {
            "id": "2",
            "type": "item"
          }
        }
      }
    },
    ...,
    ...,
      }
    ]
  }
}
```
</details>

<details>
<summary> Post to Advance Week </summary>

Request:

```http
POST /api/v1/campaigns/:id/advance_week
Content-Type: application/json
Accept: application/json
```

Body: 

```json
{
   "campaign_id": 1,
   "week": 1,
   "animal_products": 1,
   "cloth": 1,
   "farmed_goods": 1,
   ...,
}
```

Response: `status: 200`

```json
{ 
  "data": {
    "id": "1",
    "type": "campaign"
    "attributes": {
       "name": "Turing Campaign",
       "week": 0,
       "animal_products": 0,
       "cloth": 0,
       "farmed_goods": 0,
       "food": 0,
       "foraged_goods": 0,
       "metal": 0,
       "monster_parts": 0,
       "stone": 0,
       "wood": 0,
       "villagers": 120
    }
  }
}
```
</details>

### Character
<details>
<summary> Get One Character </summary>

Request:

```http
GET /api/v1/characters/:id
Content-Type: application/json
Accept: application/json
```

Response: `status: 200`

```json
{ 
  "data": {
    "id": "1",
    "type": "character"
    "attributes": {
       "name": "Cap'n Clirrk",
       "user_id": 1,
       "race": "human",
       "class": "bard",
       "image_url": UPDATE WITH HOW A URL SHOULD APPEAR
    }
  }
}
```
</details>

<details>
<summary> Create a Character </summary>

Request:

```http
POST /api/v1/characters
Content-Type: application/json
Accept: application/json
```

Body: 

```json
{
  "name": "Sambo",
  "dnd_race": "Human",
  "dnd_class": "Monk",
  "user_id": 1,
  "image_url": UPDATE WITH HOW A URL SHOULD APPEAR
}
```

Response: `status: 201`

```json
{ 
  "data": {
    "id": "2",
    "type": "character"
    "attributes": {
       "name": "Sambo",
       "user_id": 1,
       "dnd_race": "Human",
       "dnd_class": "Monk",
       "image_url": UPDATE WITH HOW A URL SHOULD APPEAR
    }
  }
}
```
</details>

### Item
<details>
<summary> Get One Item </summary>

Request:

```http
GET /api/v1/items/:id
Content-Type: application/json
Accept: application/json
```

Response: `status: 200`

```json
{ 
  "data": {
    "id": "1",
    "type": "item"
    "attributes": {
       "name": "Light Armor",
       "animal_products_cost": 1,
       "cloth_cost": 0,
       "farmed_goods_cost": 0,
       "food_cost": 0,
       "foraged_goods_cost": 0,
       "metal_cost": 1,
       "monster_parts_cost": 0,
       "stone_cost": 0,
       "wood_cost": 0
    }
  }
}
```
</details>

<details>
<summary> Get all Items </summary>

Request:

```http
POST /api/v1/items
Content-Type: application/json
Accept: application/json
```

Response: `status: 201`

```json
{ 
  "data": [{
    "id": "1",
    "type": "item"
    "attributes": {
       "name": "Light Armor",
       "animal_products_cost": 1,
       "cloth_cost": 0,
       "farmed_goods_cost": 0,
       "food_cost": 0,
       "foraged_goods_cost": 0,
       "metal_cost": 1,
       "monster_parts_cost": 0,
       "stone_cost": 0,
       "wood_cost": 0
    },
    {
    "id": "2",
    "type": "item"
    "attributes": {
       "name": "Medium Armor",
       "animal_products_cost": 1,
       "cloth_cost": 0,
       "farmed_goods_cost": 0,
       "food_cost": 0,
       "foraged_goods_cost": 0,
       "metal_cost": 2,
       "monster_parts_cost": 0,
       "stone_cost": 0,
       "wood_cost": 0
    },
  ...,
  ...,
  }
}
```
</details>

### Management Form
<details>
<summary> Update a Management Form </summary>

Request:

```http
PATCH /api/v1/management_forms/:id
Content-Type: application/json
Accept: application/json
```

Body: 

```json
{
  management_form: {
    "cloth": 20,
    "farmed_goods": 5
  }
}
```

Response: `status: 200`

```json
{ 
  "data": {
    "id": "1",
    "type": "management_form"
    "attributes": {
       "campaign_id": "1",
       "week": 1,
       "cloth": 20,
       "farmed_goods": 5,
       "food": 0,
       "foraged_goods": 0,
       ...,
    }
  }
}
```
</details>

### User Campaign
<details>
<summary> Create a User Campaign </summary>

Request:

```http
POST /api/v1/user_campaigns
Content-Type: application/json
Accept: application/json
```

Body: 

```json
{
   "user_id": 1,
   "campaign_id": 1,
   "role": 0
}
```

Response: `status: 201`

```json
{
     "message": "Successfully added user to campaign" 
}
```
</details>

## Contributors

* Billy Wallace | [GitHub](https://github.com/wallacebilly1) | [LinkedIn](https://www.linkedin.com/in/wallacebilly1/)
* Jared Hobson | [GitHub](https://github.com/JaredMHobson) | [LinkedIn](https://www.linkedin.com/in/jaredhobson/)
* Grant Davis | [GitHub](https://github.com/grantdavis303) | [LinkedIn](https://www.linkedin.com/in/grantdavis303/)
* Lance Butler | [GitHub](https://github.com/LJ9332) | [LinkedIn](https://www.linkedin.com/in/lance-butler-jr/)
* Logan Finnegan | [GitHub](https://github.com/LoganFinnegan) | [LinkedIn](https://www.linkedin.com/in/logan-finnegan/)
