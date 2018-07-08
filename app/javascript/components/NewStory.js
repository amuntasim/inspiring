import React, { Component } from 'react';
//import StoryForm from '../StoryForm';
import ContentEditable from 'react-contenteditable'
import qwest from 'qwest';

class NewStory extends Component {
    constructor(props) {
        super(props);
        this.state = {
            storyButtonsClass: 'hidden',
            expanded: '',
            selectedBookCoverFiles: [],
            submitFormProgress: 0,
            isSubmittingForm: false,
            story: {
                id: '',
                description: '',
                errors: {}
            }
        };
    }

    newStoryForm = (e) => {
        this.setState({expanded: 'expanded', storyButtonsClass: ''})
    }

    closeStoryForm = (e) => {
        this.setState({
            expanded: '',
            storyButtonsClass: 'hidden'
        })
    }

    handleDescriptionChange = (event) => {
        let { story } = this.state;
        story.description = event.target.value;
        this.setState({story: story});
    }

    render() {
        return (
            <div className={"user-input-section story-form " + this.state.expanded}>
                <img className="avatar size32"
                     src="http://localhost:3000/rails/active_storage/representations/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--1521db76f36eff6ab9724065f5be205c9e4cafc0/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCam9MY21WemFYcGxTU0lNTVRBd2VERXdNQVk2QmtWVSIsImV4cCI6bnVsbCwicHVyIjoidmFyaWF0aW9uIn19--695f63dfa8ea24388f084e6ec6ad06a5eb51f42c/profile_pic2.png"/>

                <div className={"story-form-header " + this.state.storyButtonsClass}>
                    Post
                    <button title="Close (Esc)" type="button" onClick={this.closeStoryForm}
                            className="btn btn-xs close-editable-btn ">Close (Esc)
                    </button>
                </div>

                <ContentEditable
                    className="story-editable " placeholder="What's your story?"
                    html={this.state.story.description}
                    onFocus={this.newStoryForm}
                    onChange={e => this.handleDescriptionChange(e)}
                    />

                <div className={"row margin-top-10 " + this.state.storyButtonsClass}>
                    <div className="col-md-12">
                        <div className="pull-left">
                            <div className="photoUpload">
                                <div className="form-group">
                                    <label>Uploads</label>
                                    {this.renderUploadCoversButton()}
                                    {this.renderSelectedBookCoverFiles()}
                                </div>
                                {this.renderUploadFormProgress()}
                            </div>
                        </div>
                        <div className="pull-right">
                            <button
                                disabled={this.state.isSubmittingForm}
                                onClick={e => this.handleFormSubmit()}
                                className="btn btn-primary">
                                {this.state.isSubmittingForm ? 'Saving...' : 'Save'}
                            </button>
                        </div>
                    </div>
                </div>

            </div>
        );
    }

    getNumberOfSelectedFiles = () => {
        return this.state.selectedBookCoverFiles.filter(el => {
            return el._destroy !== true;
        }).length;
    }
    renderUploadCoversButton = () => {
        let numberOfSelectedCovers = this.getNumberOfSelectedFiles();
        return (
            <div>
                <input
                    name="covers[]"
                    ref={field => (this.storyCoversField = field)}
                    type="file"
                    multiple="true"
                    disabled={this.state.isSubmittingForm}
                    accept="image/*"
                    style={{
            width: 0.1,
            height: 0.1,
            opacity: 0,
            overflow: 'hidden',
            position: 'absolute',
            zIndex: -1
          }}
                    id="story_covers"
                    onChange={e => this.handleBookCoversChange(e)}
                    className="form-control"
                    />
                <label
                    disabled={this.state.isSubmittingForm}
                    className="btn btn-success"
                    htmlFor="story_covers">
                    <span className="fa fa-cloud-upload"/>
                    &nbsp; &nbsp;
                    {numberOfSelectedCovers === 0
                        ? 'Upload Files'
                        : `${numberOfSelectedCovers} file${numberOfSelectedCovers !== 1
                        ? 's'
                        : ''} selected`}
                </label>
            </div>
        );
    }

    renderSelectedBookCoverFiles = () => {
        let fileDOMs = this.state.selectedBookCoverFiles.map((el, index) => {
            if (el._destroy) {
                return null;
            }

            return (
                <li key={index}>
                    <div className="photo">
                        <img
                            width={150}
                            src={el.id ? el.url : URL.createObjectURL(el)}
                            style={{ alignSelf: 'center' }}
                            />

                        <div
                            className="remove"
                            onClick={() => this.removeSelectedBookCoverFile(el, index)}>
                            <span style={{ top: 2 }} className="fa fa-remove"/>
                        </div>
                    </div>
                    <div className="file-name">
                        {el.name}
                    </div>
                </li>
            );
        });

        return (
            <ul className="selected-covers">
                {fileDOMs}
            </ul>
        );
    }

    renderUploadFormProgress = () => {
        if (this.state.isSubmittingForm === false) {
            return null;
        }

        return (
            <div className="progress">
                <div
                    className={
            'progress-bar progress-bar-info progress-bar-striped' +
            (this.state.submitFormProgress < 100 ? 'active' : '')
          }
                    role="progressbar"
                    aria-valuenow={this.state.submitFormProgress}
                    area-valuemin="0"
                    area-valuemax="100"
                    style={{ width: this.state.submitFormProgress + '%' }}>
                    {this.state.submitFormProgress}% Complete
                </div>
            </div>
        );
    }

    removeSelectedBookCoverFile = (cover, index) => {
        let { selectedBookCoverFiles } = this.state;
        if (cover.id) {
            selectedBookCoverFiles[index]._destroy = true;
        } else {
            selectedBookCoverFiles.splice(index, 1);
        }

        this.setState({
            selectedBookCoverFiles: selectedBookCoverFiles
        });
    }

    handleBookCoversChange = () => {
        let selectedFiles = this.storyCoversField.files;
        let { selectedBookCoverFiles } = this.state;
        for (let i = 0; i < selectedFiles.length; i++) {
            selectedBookCoverFiles.push(selectedFiles.item(i));
        } //end for

        this.setState(
            {
                selectedBookCoverFiles: selectedBookCoverFiles
            },
            () => {
                this.storyCoversField.value = null;
            }
        );
    }

    buildFormData = () => {
        let formData = new FormData();
        formData.append('story[description]', this.state.story.description);

        let { selectedBookCoverFiles } = this.state;
        for (let i = 0; i < selectedBookCoverFiles.length; i++) {
            let file = selectedBookCoverFiles[i];
            if (file.id) {
                if (file._destroy) {
                    formData.append(`story[photos_attributes][${i}][id]`, file.id);
                    formData.append(`story[photos_attributes][${i}][_destroy]`, '1');
                }
            } else {
                formData.append(
                    `story[photos][]`,
                    file,
                    file.name
                );
            }
        }
        return formData;
    }


    submitForm = () => {
        var self = this;
        var url = REACT_CLIENT.api.base_url + '/stories/';
        qwest.post(url, this.buildFormData(), null, function (xhr) {
            xhr.upload.onprogress = function (progressEvent) {
                let percentage = progressEvent.loaded * 100.0 / progressEvent.total;
                self.setState({
                    submitFormProgress: percentage
                });
            };
        }).then(function (xhr, resp) {
            if (resp) {
                if (resp.story) {
                    console.log(resp.story)
                    self.props.onStoryAdded(resp.story)
                }
                self.setState({
                    isSubmittingForm: false,
                    story: {description: ''}
                });
                self.closeStoryForm()
            }
        }).catch(function (e, xhr, response) {
            let { story } = self.state;
            story.errors = error.response.data;
            this.setState({
                isSubmittingForm: false,
                submitFormProgress: 0,
                story: story
            });
        });

    }

    handleFormSubmit = () => {
        let { story } = this.state;
        story.errors = {};
        this.setState(
            {
                isSubmittingForm: true,
                story: story
            },
            () => {
                this.submitForm();
            }
        );
    }
}

export default NewStory;
